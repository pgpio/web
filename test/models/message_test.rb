require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Message Model" do
  it 'can construct a new instance' do
    @message = Message.new
    refute_nil @message
  end
end
