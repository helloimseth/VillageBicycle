module ApplicationHelper

  def auth_token
      <<-HTML.html_safe
        <input type="hidden"
               name="authenticity_token"
               value="#{form_authenticity_token}">
      HTML
  end

  def log_out_button
    <<-HTML.html_safe
      <form action="#{sessions_url}" method="post">
        <input type="hidden" name="_method" value="delete">
        #{auth_token}
        <button>Log Out</button>
      </form>
    HTML
  end

  def time_dropdown
    dropdown = ""
    (1..24).each do |hour|
      [00, 15, 30, 45].each do |minute|
        dropdown << <<-HTML
          <option value='#{hour * 100 + minute}'>#{hour}:#{minute}</option>
          HTML
      end
    end
    dropdown.html_safe
  end

end
