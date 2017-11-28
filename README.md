reply_without_link branch

[実現したかったこと]
・talk/show.html.erbでcomment一覧を表示し、各commentに対してreplies_areaを設定
・Replyボタンを押下すると、reply_formが出現し、formに内容を入力して投稿ボタンを押すとreplyが作成

[実現できたこと]
・各commentに対するReply_fromの表示

[実現できなかったこと]
・Reply内容の投稿（できなかったが、原因調査せず未着手）
・Replyボタンを押下した際にreply_formを出現させる（未着手）

[その他できなかったこと]
・comment_formに@commentsの最後の@commentの内容が反映されてしまう（新規コメント入力formに@commentの内容が表示されてしまう）
・comment_formにて新規コメントを作成しようとすると、@commentの内容がUPDATEされる

[状況]
params:
{"controller"="talks", "action"="show", "id"="1"}

・talks_controller.rb
class TalksController < ApplicationController
  def show
    @comment  (nil )     = @talk.comments.build
    @comments (list)     = @talk.comments
    @summary  (nil )     = @talk.summaries.build
    @summaries(list)     = @talk.summaries
    @reply    (nil )     = @comment.replies.build
    @replies  (list_nil) = @comment.replies
  end
end

・talks/show.html.erb
<div id="comments_area">
  <%= render partial: 'comments/index', locals: { replies: @replies, comments: @comments, talk: @talk } %>
</div>
  <%= render partial: 'comments/form',  locals: { comment: @comment, talk: @talk } %>
</div>
     
・comments/_index.html.erb
<ul>
  <% comments.each do |comment| %>
    <% unless comment.id.nil? %>         
###
    この行を追加することで・replies/_form.html.erbに@commentがnilでなく、データを含んだ状態で受け渡される
    よってform_for([talk,comment,reply])のtalk_comment_reply_pathが通るようになる（この行がないと、commentがnilでRoutingError）
    しかし、CommentFormにリストComments最後の@commentの情報が反映されてしまうようになる
    <% @comment = comment %>
###
      <li>
        <p class="left"><%= comment.content %> @<%= comment.user.name %></p>
        <% if current_user.id == comment.user.id %>
          <p class="right">
            <%= link_to '', edit_talk_comment_path(talk, comment), class: "fa fa-pencil-square-o fa-lg" %>
            <%= link_to '',      talk_comment_path(talk, comment), class: "fa fa-trash-o fa-lg",
                method: :delete, remote: true, data: { confirm: '本当に削除していいですか？' } %>
          </p>
        <% end %>
        <p class="right">
          <div id="replies_area">
            <%= render partial: 'replies/index',
             locals: { replies: @replies, comment: @comment, talk: @talk } %>
          </div>
        </p>
        <% unless current_user.id == comment.user.id %>
          <p class="right">
              <%= render partial: 'replies/form' ,
               locals: {   reply: @reply  , comment: @comment, talk: @talk } %>
            </div>
            <%= link_to '', edit_talk_comment_path(talk, comment), class: "fa fa-reply fa-lg" %>
          </p>
        <% end %>
      </li>
    <% end %>
  <% end %>
</ul>

・replies/_form.html.erb
<%= form_for([talk,comment,reply], remote: true) do |f| %>
  <% if reply.errors.any? %>
    <div id="error_explanation">
      <h2><%= reply.errors.count %>件のエラーがあります。</h2>

      <ul>
      <% reply.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>
  <%= f.hidden_field :talk_id %>
  <div class="field">
    <%= f.text_field :content, placeholder: "リプライ内容", class: "form-control"  %>
  </div>
  <div class="actions">
    <%= f.submit '返答する' %>
  </div>
<% end %>
