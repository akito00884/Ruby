class Post < ActiveRecord::Base

# ページングを実装する:Modelの設定					
  default_scope :order => 'created_at DESC'
  paginates_per 5

  attr_accessible :content, :title

  has_many :comments

  validates :title, :presence => true
  validates :content, :presence => true,
                      :length => { :minimum => 5 }

  #  検索機能の実装
    scope :content_or_title_matches, lambda {|q|  
    where 'content like :q or title like :q', :q => "%#{q}%"  
  }

  #　カテゴリーの追加：テーブルを関連付けます   
  attr_accessible :content, :title, :category_id
  has_many :categories

end
