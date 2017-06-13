class BoardController < ApplicationController
    #before_action :authenticate_user!
    def create
            board = Boarddb.new
            board.title = params[:title]
            board.content = params[:content]
            board.password = params[:password]
            board.user_id = current_user.id
            if board.save
                redirect_to "/board/index"
            else
                render :text => board.errors.messages[:title].first
            end
    end
    
    def delete
        Boarddb.find_by_id(params[:id]).destroy
        
        redirect_to "/board/index"
        
    end
    
    def edit
        @board = Boarddb.find_by_id(params[:id])
    end
    
    def index
        @boards = Boarddb.all
    end
    
    def new
        if user_signed_in?
            
        else
            redirect_to '/users/sign_in'
        end
    end
    
    def show
        @board = Boarddb.find_by_id(params[:id])
        @comments = Boarddb.find_by_id(params[:id]).comments.reverse
        
    end
    
    def update
        board = Boarddb.find_by_id(params[:id])
        board.title = params[:title]
        board.content = params[:content]
        board.save
        
        redirect_to "/board/#{params[:id]}/show"
    end
    
    def kakao
        @content = params[:content]
        @id = params[:board_id]
        comment = Comment.new
        comment.content = @content
        comment.boarddb_id = @id
        comment.save
        
        redirect_to "/board/#{@id}/show"    
    end
end