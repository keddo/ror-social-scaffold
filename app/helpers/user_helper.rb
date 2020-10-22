module UserHelper
  def not_current_user?(user)
    current_user != user
  end

  def display_action_btns(user)
    if current_user.friend?(user)
      content_tag :td do
        content_tag :div, class: 'buttons' do
          link_to friendship_path(user), class: 'button is-info is-light',
                                         method: :delete, data: { confirm: "Are you sure you want to Unfriend #{user.name}" } do
            content_tag :i, class: 'fas fa-user-plus mr-2'
            content_tag :span, 'Unfriend'
          end
        end
      end
    elsif current_user.pending_requests.include?(user)
      content_tag :td do
        content_tag :div, class: 'buttons' do
          link_to friendship_path(user), class: 'button is-warning is-light' do
            content_tag :i, class: 'fas fa-user-plus mr-2'
            content_tag :span, 'Request sent'
          end
        end
      end
    elsif current_user.friend_requests.include?(user)
      content_tag :div, class: 'buttons' do
        link_to friendship_confirm_path(user), class: 'button is-success is-light', method: :post do
          content_tag :i, class: 'fas fa-user-plus mr-2'
          content_tag :span, 'Accept'
        end
      end
      content_tag :div, class: 'buttons' do
        link_to friendship_reject_path(user), class: 'button is-danger is-light', method: :delete do
          content_tag :i, class: 'fas fa-user-plus mr-2'
          content_tag :span, 'Reject'
        end
      end
    else
      content_tag :td do
        content_tag :div, class: 'buttons' do
          link_to friendships_path(user_id: current_user.id, friend_id: user.id), class: 'button is-info is-light', method: :post do
            content_tag :i, class: 'fas fa-user-plus mr-2'
            content_tag :span, 'Add Friend'
          end
        end
      end
    end
  end
end
