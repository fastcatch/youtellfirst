module ApplicationHelper

  def link_to_add_nested_item(name, f, association, partial_path, html_options={})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(partial_path, :f => builder)
    end

    title = "<i class='icon-plus'></i>&nbsp;&nbsp;".html_safe + name
    options = html_options
    options[:class] = Array(options[:class]||[]) << ['js-add-nested-item', 'btn', 'btn-small', 'btn-primary']
    options['data-association'] = association
    options['data-content'] = h(fields.gsub!(/"/,"'"))
    link_to(title, '#', options)
  end

end
