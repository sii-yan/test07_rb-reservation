class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # 施設一覧
  def index
    @rooms = current_user.rooms
  end

  # 施設詳細
  def show
    @reservation = Reservation.new
  end

  # 施設新規作成フォーム
  def new
    @room = Room.new
  end

   # 施設作成
   def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: "宿泊施設が登録されました。"
    else
      render :new
    end
  end

  # 施設編集フォーム
  def edit
  end

  # 施設更新
  def update
    if @room.update(room_params)
      redirect_to @room, notice: "宿泊施設情報が更新されました。"
    else
      render :edit
    end
  end

  # 施設削除
  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "宿泊施設が削除されました。"
  end

  # 施設検索
  def search
    @rooms = Room.all

    # エリア検索（住所が対象）
    if params[:area].present?
      valid_areas = ["東京", "大阪", "京都", "札幌"]
      if valid_areas.include?(params[:area])
        @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
      end
    end

    # フリーワード検索（施設名・施設詳細が対象）
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", keyword, keyword)
    end

    render :index
  end

  # 登録済みルーム一覧
  def own
    @rooms = current_user.rooms
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def authorize_user!
    redirect_to rooms_path, alert: "権限がありません。" unless @room.user == current_user
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
