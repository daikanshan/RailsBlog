class ManageController < ApplicationController
  before_action :build_manage_cache
  before_action :check_login
  before_action :set_nav

  private
  def check_login
    if !session[:manage_id]
      redirect_to manage_login_url
    end
  end

  def build_manage_cache
    # @cache = Cache.new("admin-")
  end

  def set_nav
    # 如果在开发模式下nav在每次页面加载时都会刷新
    # @navs = @cache.get 'nav', nil, Rails.env.development? do
    result = []
    raw = YAML.load(File.read('config/ext/manage_nav.yml'))["nav"]
    raw.each do |item|
      args = {}
      controllers = item["controllers"].split('|').map{|e| 'manage/'+e}
      actions = item["actions"].split('|').map{|e| e.split(',')}
      (0..controllers.length).each do |i|
        args[controllers[i]] = actions[i]
      end
      controller, action = item["path"].split('/')
      result << {text: item["text"], icon: item["icon"], options: {controller: 'manage/' + controller, action: action},args:args}
    end
    @navs = result
    # end
  end
end
