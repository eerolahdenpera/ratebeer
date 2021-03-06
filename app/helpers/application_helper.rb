module ApplicationHelper
  def edit_and_destroy_buttons(item)
    unless current_user.nil?
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-warning")
      if current_user.admin
        del = link_to('Destroy', item, method: :delete,
                    data: {confirm: 'Are you sure?' }, class:"btn btn-danger")
        raw("#{edit} #{del}")
      else
        raw("#{edit}")
      end
    end
  end
end