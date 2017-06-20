<%if current_user.admin? %>
  <% @sc.each do |c|%>
    < tr>
      <td> <%= c %></td>
    </tr>
  <%end%>
<% end %>