require "minitest/autorun"
# require_relative './worker.rb'

class TestWorker < Minitest::Test
    def test_worker
        worker = Worker.new
        assert worker.save
    end
end