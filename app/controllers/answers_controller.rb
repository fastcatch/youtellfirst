class AnswersController < ApplicationController

  # index: works with a logged in user only
  def index
    @answers = Answer.where(email: current_user.email)
  end

  # show: only works directly with UUID, user does not have to be logged in
  def show
    @answer = Answer.find_by_uuid(params[:id])
    @question = @answer.question
  end

  # edit: only works directly with UUID, user does not have to be logged in
  def edit
    @answer = Answer.find_by_uuid(params[:id])
    if !@answer.pending?
      redirect_to(answer_path(@answer.uuid), notice: 'You have already answered this question.') and return
    end

    @question = @answer.question

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer }
    end
  end

  # update: only works directly with UUID, user does not have to be logged in
  def update
    @answer = Answer.find_by_uuid(params[:id])
    @question = @answer.question

    respond_to do |format|
      begin
        if @answer.update_attributes(params[:answer])
          format.html { redirect_to answer_path(@answer.uuid), notice: 'Your answer was successfully saved.' }
          format.json { render json: @answer, status: :created, location: answer_path(@answer.uuid) }
        else
          format.html { render action: "edit", location: edit_answer_path(@answer.uuid) }
          format.json { render json: @answer.errors, status: :unprocessable_entity, location: edit_answer_path(@answer.uuid) }
        end
      rescue ActiveRecord::ReadOnlyRecord
        format.html { redirect_to answer_path(@answer.uuid), notice: "You cannot change the answer" }
        format.json { render json: @answer.errors, status: :unprocessable_entity, location: answer_path(@answer.uuid) }
      end
    end
  end

end
