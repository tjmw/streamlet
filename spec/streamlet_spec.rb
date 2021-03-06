RSpec.describe Streamlet do
  it "has a version number" do
    expect(Streamlet::VERSION).not_to be nil
  end

  it "returns the result of chaining successful operations" do
    success = 1

    result = Streamlet.new { success }.
      and_then { |val| increment(val) }.
      and_then { |val| increment(val) }.
      and_then { |val| increment(val) }.
      result

    expect(result).to eql(4)
  end

  it "returns the failure result if any operation fails" do
    success = 1
    failure = nil

    result = Streamlet.new { success }.
      and_then { |val| increment(val) }.
      and_then { failure }.
      and_then { |val| increment(val) }.
      and_then { |val| increment(val) }.
      result

    expect(result).to eql(nil)
  end

  it "supports specifying a custom success test" do
    success = { ok: 1 }
    failure = { error: "failure message" }

    result = Streamlet.new { success }.
      set_success_test { |resp| resp.key?(:ok) }.
      and_then { |val| nested_increment(val) }.
      and_then { failure }.
      and_then { |val| nested_increment(val) }.
      and_then { |val| nested_increment(val) }.
      result

    expect(result).to eql({ error: "failure message" })
  end

  def increment(val)
    val += 1
  end

  def nested_increment(val)
    { ok: val[:ok] += 1 }
  end
end
