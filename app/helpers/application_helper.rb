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
end
