class ItemsController < ApplicationController

  before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote] # цей фильтыр буде выполняться в методах: 
                                                                # [:show, :edit, :update, :destroy] код якый буде выполняться
                                                                # дывысь в private метод find_item
  before_filter :check_if_admin, only: [:edit, :update, :new, :create, :destroy] # цей фильтр запрещае доступ к определьоным 
                                                                            # страницам пользувателям. До цых страниц буде доступ тилькы Админку
                                                                            # # дывысь в private метод check_if_admin

  #цей метод буде производить поиск в бази данных и искать все те товары которые есть на данный момент в магазине и выводыть их
  def index
    @items = Item
    @items = @items.where("price >= ?", params[:price_from])       if params[:price_from]
    @items = @items.where("create_at >= ?", 1.day.ago)             if params[:today]
    @items = @items.where("votes_count >= ?", params[:votes_from]) if params[:votes_from]
    @items = @items.order("votes_count DESC", "price")
  end

  # цей метод выводе на екран товары яки больше 1000 руб
  def expensive
    @items = Item.where("price > 1000")
    render "index"
  end

  # /items/1 GET
  #цей метод буде шукать определьной товар в бази данных
  def show
    unless @item # @item = Item.find(params[:id])
      render text: "Page not found", status: 404 # а если товар не найден в бази даных то мы выводм 404 ошыбку
    end
  end

  # /items/new GET
  # цей екшен выводе на екран форму с помощю якой я можу создать товар
  def new
    @item = Item.new
  end

  # /items/1/edit GET будет выводить на екран форму уже заполнену данами из того товара которого я редактирую
  def edit
  end

  #@user = User.new(user_params)
  # /items POST
  # цей метод будет заниматься созданиям новго товара в магазине. Будео обрабатовать запрос и создавать торвар
  def create
    @item = Item.create(item_params) # передаю содержимое item_params
    if @item.errors.empty? # проверка есть ли ошыбкы у обекта item
      redirect_to item_path(@item) # отправляю пользувателя прямо на страницу с инф о новь созданом обекте /items/:id
    else # а в случаи если у нас произошла ошыбка и валидации не прошли 
      render "new" # тогда снова пользувателя верну на страницу где создавать товар
    end
  end

  # /items/1 PUT
  # цей екшен будет обрабатувать запрос поступившы когда пользуватель отправить ету форму
  def update
    @item.update_attributes(item_params) #
    if @item.errors.empty? # проверка есть ли ошыбкы у обекта item
      redirect_to item_path(@item) # отправляю пользувателя прямо на страницу с инф о новь созданом обекте /items/:id
    else # а в случаи если у нас произошла ошыбка и валидации не прошли 
      render "edit" # тогда снова пользувателя верну на страницу где создавать товар
    end
  end

  # /items/1 DELETE
  # цей метод буде удалять товары
  def destroy
    @item.destroy 
    redirect_to action: "index"
  end

  # цей метод позволяет нам голосувать за товары 
  def upvote
    @item.increment!(:votes_count) # ця строка обновить значения атрибута :votes_count и увеличев на 1 и затем авт сохране
                                  # абект в базу данных
    redirect_to action: :index             
  end

  private 
  def item_params
    params.require(:item).permit(:price,:name,:description,:weight)
  end

  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end
end
