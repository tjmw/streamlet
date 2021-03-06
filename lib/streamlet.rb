class Streamlet
  def initialize(*args, &operation)
    @args = args
    @operation = operation
    @success_test = proc { |resp| !!resp }
  end

  def set_success_test(&success_test)
    @success_test = success_test
    self
  end

  def and_then(&next_operation)
    if success_test.call(result)
      Streamlet.new(result, &next_operation).
        set_success_test(&success_test)
    else
      Failure.new(result)
    end
  end

  def result
    @result ||= operation.call(*args)
  end

  private

  attr_reader :args, :success_test, :operation

  class Failure
    def initialize(result)
      @result = result
    end

    def and_then(&_)
      self
    end

    attr_reader :result
  end
end
