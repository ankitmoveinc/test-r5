module ApplicationHelper

  def logged_in?
    false
  end

  def navbar_active_class(nav)
    case nav
    when 'buy'
      buy_controllers = set_ldp_navbar('buy')
      current_page?(root_path) || buy_controllers.include?(controller.controller_name) ? 'active' : ''
    when 'rent'
      rent_controllers = set_ldp_navbar(rent)
      rent_controllers.include?(controller.controller_name) ? 'active' : ''
    when 'local'
      controller.controller_name == ZONE_HOME_PAGE ? ACTIVE : BLANK
    when 'new'
      controller.controller_name == VIDEOS_HOME ? ACTIVE : BLANK
    else
      ''
    end
  end
end
