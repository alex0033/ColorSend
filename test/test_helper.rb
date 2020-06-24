ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
include ActionDispatch::TestProcess

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def set_micropost(user)
    micropost = user.microposts.build
    image = fixture_file_upload('test/fixtures/test.png', 'image/png')
    micropost.image.attach(image)
    micropost.save
    return micropost.reload
  end
end
