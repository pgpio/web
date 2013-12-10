require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

# Message Specs
describe "Message Model" do
  it 'can construct a new instance' do
    @message = Message.new
    refute_nil @message
  end

  it 'requires a valid ID' do
    @m = Message.new
    begin
      @m.id = ""
    rescue RuntimeError => e
      assert e.message.eql? "Not a valid ID."
    end
  end

end
