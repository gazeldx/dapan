describe Trading do

  describe "#get_target_date" do
    # before do
    #   @time = 6
    # end

    it "return tomorrow's date if tomorrow is trading day and now is after trading time" do
      Time.stubs(:now).returns(Time.parse("2014-10-27 21:33:03 +0800"))
      Date.stubs(:today).returns(Date.parse('27 Oct 2014'))
      test_obj = Object.new.extend(Trading)
      expect(test_obj.get_target_date).to eq(Date.parse('28 Oct 2014'))
    end
  end
  
end
