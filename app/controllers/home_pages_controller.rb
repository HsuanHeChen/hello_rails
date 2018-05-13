class HomePagesController < ApplicationController
  
  def index
    set_meta_tags(site: '智慧科睿 | Your idea, I carry.', 
                  title: 'IntelligentCarry',
                  description: 'Intelligent Carry提供iOS/Android Mobile APP設計、網頁設計及使用者體驗優化服務。iOS APP design | Android APP design| iPhone design | iPAD design | 網頁設計 | web design | RWD design | UI/UX design',
                  keywords: 'app,web,ios,android,rwd,UX',
                  reverse: true,
                  og: {
                    site_name: "智慧科睿 iOS/Android/web design",
                    title: 'IntelligentCarry',
                    type: 'app and web design',
                    description: 'Intelligent Carry提供iOS/Android Mobile APP設計、網頁設計及使用者體驗優化服務。iOS APP design | Android APP design| iPhone design | iPAD design | 網頁設計 | web design | RWD design | UI/UX design',
                    url: 'http://www.intelligentcarry.com/'})
  end

  def hello_rails
  end

  def policy
  end

  def terms
  end

end
