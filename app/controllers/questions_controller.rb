class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  # GET /questions
  # GET /questions.json
  def index
    @questions = current_user.questions.order('created_at DESC').includes(:answers).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = current_user.questions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = current_user.questions.new
    @question.answers.new(email: current_user.email)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    blow_up_multiple_invitations
    @question = current_user.questions.new(params[:question])
    respond_to do |format|
      if check && @question.save
        pending_answers = @question.answers.pending
        # send mails
        # TODO: make it a background job
        pending_answers.each { |answer| AnswerMailer.request_for_answer(answer).deliver }

        notice = pending_answers.count > 0 ? view_context.pluralize(pending_answers.count,'Request') + ' for Answer sent in email' : ''
        format.html { redirect_to @question, notice: notice }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

private

  # these checks are nearly impossible to do at model level due to the nested structure
  def check
    alerts = []
    missing_answers = !params[:question]['answers_attributes'].first.second.is_a?(Hash) rescue true

    # check if question is filled in (could use automatic validations but visually cleaner this way)
    alerts << 'You have to enter a question' if params[:question]['text'].blank?
    # check if first answer has 'answer filled in'
    alerts << 'You have to enter an answer' if missing_answers || params[:question]['answers_attributes'].first.second['text'].blank?
    # check if there's at least one invitee
    alerts << 'You have to invite at least one person' if missing_answers || params[:question]['answers_attributes'].count{|item| item.second['email'].present?} < 2

    flash[:alert] = alerts.flatten.join("<br/>").html_safe unless alerts.empty?
    alerts.empty?
  end

  # any invitation may contain several comma separated email addresses
  # we split them up here into individual ones
  def blow_up_multiple_invitations
    return unless params[:question]['answers_attributes'].is_a?(Hash)
    answers_attributes = params[:question].delete('answers_attributes')
    new_answers = {}
    answers_attributes.each_pair do |key, attrs|
      emails = (attrs['email'] || "").split(',')
      # clear all but the first email address from the original entry
      attrs['email'] = emails.shift
      # create new (copy) entries for all other email addresses
      emails.each { |email| new_answers[(10000+rand(1000)).to_s] = attrs.merge({email: email}) }
    end
    params[:question]['answers_attributes'] = answers_attributes.merge(new_answers)
  end
end
