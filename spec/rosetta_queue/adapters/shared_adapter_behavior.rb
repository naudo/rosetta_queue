module RosettaQueue
  module Gateway

    describe "an adapter", :shared => true do

      before(:each) do
        ::RosettaQueue::Destinations.stub!(:lookup).and_return("foo")
      end

      def do_publishing
        @adapter.send_message('queue', 'message', 'options')
      end

      def do_receiving_with_handler
        @adapter.receive_with(@handler)
      end

      describe "#receive_once" do

        it "should return the message from the connection" do
          @adapter.receive_once("foo", {:persistent => false}).should == @msg
        end

      end

      describe "#receive_with" do

        it "should look up the destination defined on the class" do
          when_receiving_with_handler {
            Destinations.should_receive(:lookup).with(:foo).and_return("foo")
          }
        end

      end
      
      describe "#disconnect" do
        
        it "allows disconnecting" do
          @adapter.should respond_to(:disconnect)
        end
      end

    end
  end
end
