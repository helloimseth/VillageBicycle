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

  def list_requests(requests)
    request_string = "<ul>"

    requests.each do |request|
      request_string << <<-HTML
            <li>
              <em><a href="#{user_url(request.requestor)}">#{request.requestor.name}'s</a>
              request for
              <a href="#{bike_url(request.bike)}">#{request.bike.name}</a></em>
              <br>
              From: #{request.start.to_formatted_s(:short)}
              <br>
              To: #{request.end.to_formatted_s(:short)}
            </li>
      HTML
    end

    request_string << "</ul>"
    request_string.html_safe
  end

end
