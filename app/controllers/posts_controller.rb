# coding: utf-8

class PostsController < ApplicationController
    
    def index

       # @posts = Post.all(:order => "created_at DESC")

       #検索機能をつける
       @search_form = SearchForm.new (params[:search_form])

       @posts = Post.all(:order => "created_at DESC")
       @posts = Post.scoped(:order => "created_at ASC").page(params[:page]).per(5)

       if @search_form.q.present?
          @posts = @posts.content_or_title_matches @search_form.q
       end

       # @posts = Post.scoped(:order => "created_at DESC").page(params[:page]).per(5)

    end

    #日･月･年別アーカイブ一覧
    def day
    @posts = Post.all(:order => "created_at DESC")
    @post_days = @posts.group_by { |t| t.created_at.beginning_of_day }
    end

    #日･月･年別アーカイブ一覧
    def day_list
    @date = params[:date]
    y = @date[0,4]
    m = @date[4,2]
    d = @date[6,2]
    i = y + '-' + m + '-' + d

    @posts = Post.where(["created_at between ? and ?", "#{i} 00:00:00", "#{i} 24:00:00"]).order("created_at DESC")
    end

    # カテゴリ追加：カテゴリ一覧のコントローラーの設定を行います。   
    def category_list
    @cateories = Category.all
    @posts = Post.all(:order => "category_id DESC")
    @post_categories = Post.find(:all).group_by(&:category_id)
    end

    # カテゴリ追加：カテゴリ詳細のコントローラー設定を行います。 
    def cat_list
    cat = params[:cat]
    if cat.nil?
         @posts = Post.find(:all, :conditions => { :category_id => nil })
         @cat = Category.find_by_id(nil)
      else
         @posts = Post.find(:all, :conditions => { :category_id => cat })
         @cat = Category.find(cat)
       end
    end

    def show
    	@post = Post.find(params[:id])
        @comment = Post.find(params[:id]).comments.build
        @cateories = Category.all
        @cat = Category.find_by_id(@post.category_id) 
    end
    
    def new
    	@post = Post.new
    end

    def create
    	@post = Post.new(params[:post])
        if @post.save
          redirect_to posts_path, notice: '作成されました！'
        else
    	render action: 'new'
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update_attributes(params[:post])
            redirect_to posts_path, notice:'更新されました！'
        else
            render action: 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        render json:{ post: @post }
    end

end
