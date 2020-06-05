require 'rails_helper'
RSpec.describe "StaticPages", type: :request do
    describe '静的なページ' do
        context "トップページが正しく表示される" do
            it 'リクエストは200 OKとなること' do
                get root_path
                expect(response.status).to eq 200
            end
        end
        context "このサイトについて画面が正しく表示される" do
            it 'リクエストは200 OKとなること' do
                get about_path
                expect(response.status).to eq 200
            end
        end
        context "お問い合わせ画面が正しく表示される" do
            it 'リクエストは200 OKとなること' do
                get contact_path
                expect(response.status).to eq 200
            end
        end
    end
end
