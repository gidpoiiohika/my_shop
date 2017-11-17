class Item < ApplicationRecord

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  attr_accessible :price, :name, :real, :weight, :description # attr_accessible етот метод позволяет мени устанавлювать через метод new
                                                              #  i = Item.new(price: 100, name: "Item 1", и так дали)
  # http://guides.rubyonrails.org/active_record_validations.html#validation-helpers
  # цена товара должна быть больше 0 або постой, проверка "цена мого товара больше 0"
  validates :price, { numericality: { greater_than: 0, allow_nil: true} } # Вызвав метод validates тоди я передаю имя поля йкого я хочу с валидирувать
                                                         # и затем я передаю этому методу хеш {} и валидацию numericality и значения
                                                         # этого ключа тоже должен буть хеш {} в которому я указую необходимою опцию
                                                         # для данной валидации greater_than: 0 и allow_nil: true
  # эта валидация провиряет, або поля :name, :description должны обизательно быть заполнени.
  validates :name, presence: true # Вызвав метод validates тоди я передаю имя полей яки я хочу с валидирувать :name, :description
                                                # и затем я перадаю етому методу хеш и валидацию presence: и передаю значения true
  
  has_many :positions
  has_many :carts, through: :positions
  has_many :comments, as: :commentable

  #validates :name, presence: true
  # асоциации
  #belongs_to :category

  # Колбэки это методы, которые вызываются в определенные моменты жизненного цикла объекта. 
  # С колбэками возможно написать код, который будет запущен, когда объект Active Record создается, сохраняется, обновляется, 
  # удаляется, проходит валидацию или загружается из базы данных.
  #after_initialize {} # этот код {} будет выполнен после того как я напишу  Item.new; Item.first
  #after_save {} # этот код {} будет выполнен после того как я напишу Item.save; Item.create; item.update_attributes()
  #after_create { category.inc(:items_count, 1) } # этот колбэк мени нужен для того шоб пры добавлении нового товара
                                                 # обновлять щочык товаров в ций категории вызываю метод category. и на 
                                                 # ньому вызываю метод inc и передаю названия поля содержащего щочыка
                                                 # и за тем чысло на которые я хочу увеличеть
  #after_update {} # опдейт щощеков
  #after_destroy { category.inc(:items_count, -1) } # этот код {обновляю щочык и уменшем ее значения на 1 } будет выполнен после того как я напишу item.destroy                                           
end
