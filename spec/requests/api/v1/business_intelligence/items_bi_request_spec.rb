require 'rails_helper'

describe "Items BI API" do
  describe "Item class" do
    it '.best day' do
      item1 = create(:item)
      invoice_list1 = create_list(:invoice, 3, created_at: "2018-04-30 10:45:00 UTC")
      invoice_list2 = create_list(:invoice, 4, created_at: "2018-05-30 10:45:00 UTC")

      create(:invoice_item, invoice: invoice_list1[0], item: item1)
      create(:invoice_item, invoice: invoice_list1[1], item: item1)
      create(:invoice_item, invoice: invoice_list1[2], item: item1)
      create(:invoice_item, invoice: invoice_list2[0], item: item1)
      create(:invoice_item, invoice: invoice_list2[1], item: item1)
      create(:invoice_item, invoice: invoice_list2[2], item: item1)
      create(:invoice_item, invoice: invoice_list2[3], item: item1)

      create(:transaction, invoice: invoice_list1[0], result: "Success")
      create(:transaction, invoice: invoice_list1[1], result: "Success")
      create(:transaction, invoice: invoice_list1[2], result: "Success")

      create(:transaction, invoice: invoice_list2[0], result: "Success")
      create(:transaction, invoice: invoice_list2[1], result: "Success")
      create(:transaction, invoice: invoice_list2[2], result: "Failure")
      create(:transaction, invoice: invoice_list2[3], result: "Failure")

      get "/api/v1/items/#{item1.id}/best_day"

      day = JSON.parse(response.body)

      expect(day).to eq({"best_day"=>"2018-04-30T10:45:00.000Z"})
    end
  end
end
