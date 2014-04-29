if !(Amnesia) do throw "amnesia is 404" end
use Amnesia

defdatabase DbTest do

  deftable Ping, [{:id, autoincrement}, :content, :reply_id] do
    @type t :: Ping[id: integer, content: String.t, reply_id: integer]
    
    def reply(self) do
      Ping.read(self.reply_id)
    end
    
  end
  
end

Amnesia.Schema.create
Amnesia.start    
DbTest.create(disk: [node])
DbTest.wait

defmodule DatabaseTest do
  use ExUnit.Case
  use Amnesia
  use DbTest
  
  # setup
  
  setup_all do
    :error_logger.tty(false)

    setup_and_test_mocks
     
    :ok
  end

  teardown_all do
    :error_logger.tty(true)
    
    Db.destroy
    Amnesia.stop
    Amnesia.Schema.destroy
            
    :ok
  end
  
  # tests
  
  test "read a ping" do
    Amnesia.transaction do
      assert "lol" == Ping.read(1).content
    end
  end

  defp setup_and_test_mocks do
    Amnesia.transaction do
      ping  = Ping[content: "lol"].write
      reply = Ping[content: "nvm", reply_id: ping.id].write
    end
    
    Amnesia.transaction do
      assert 2 == length Ping.where(id > 0).values
    end
  end

end