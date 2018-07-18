class Micropost < ApplicationRecord
  belongs_to :user
  scope :micropost_desc, -> {order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.maximum.length_micropost_content}
  validate :picture_size

  private

    def picture_size
      return if picture.size <= Settings.maximum.length_megabytes_image.megabytes
      errors.add :picture, t("size_image_error")
    end
end
