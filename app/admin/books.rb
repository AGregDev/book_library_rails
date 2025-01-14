ActiveAdmin.register Book do
  permit_params :title, :author, :library_id, :borrower_id, category_ids: []

  filter :title
  filter :author
  filter :library
  filter :categories, as: :select, collection: Category.all

  index do
    selectable_column
    id_column
    column :title
    column :author
    column :library
    column :categories do |book|
      book.categories.map(&:name).join(", ")
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :author
      f.input :library, as: :select, collection: Library.all
      f.input :borrower_id
      f.input :category_ids, as: :check_boxes, collection: Category.all
    end
    f.actions
  end

  after_create do |book|
    Log.create(user: current_user, action: "Created Book", details: "Admin #{current_user.email} created book #{book.title}")
  end

  after_update do |book|
    Log.create(user: current_user, action: "Updated Book", details: "Admin #{current_user.email} updated book #{book.title}")
  end

  after_destroy do |book|
    Log.create(user: current_user, action: "Deleted Book", details: "Admin #{current_user.email} deleted book #{book.title}")
  end

  controller do
    def create
      book_params = params.require(:book).permit(:title, :author, :library_id, :borrower_id, category_ids: [])
      category_ids = book_params.delete(:category_ids).reject(&:blank?)
      book = Book.create(book_params)

      category_ids.each { |cat_id| BookCategory.create(category_id: cat_id, book_id: book.id) }
      if book.persisted?
        redirect_to admin_book_path(book), notice: "Book was successfully created."
      else
        render :new, alert: "There was an error creating the book."
      end
    end
  end
end
