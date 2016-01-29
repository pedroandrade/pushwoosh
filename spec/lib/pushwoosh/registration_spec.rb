require "spec_helper"

describe Pushwoosh::Registration do
  let(:auth_key) { '5555-5555' }

  let(:app_key) { '555555555' }

  let(:device_token) { '999999999999999999999999999999' }

  let(:hwid) { '123-456-789' }

  let(:base_auth) do
    {
      application: app_key,
      auth_key: auth_key
    }
  end

  let(:timezone) { 3600 }

  let(:device_type) { 1 }

  let(:registration_attributes) do
    {
      push_token: device_token,
      hwid: hwid,
      timezone: timezone,
      device_type: device_type
    }
  end

  let(:auth_attributes) do
    base_auth
  end

  subject { described_class.new(auth_attributes) }

  describe "#register" do
    context "with valid params" do
      let(:response) do
        VCR.use_cassette "pushwoosh/register_success" do
          subject.register(registration_attributes)
        end
      end

      it "responds with success" do
        expect(response.code).to eq 200
      end
    end

    context "with invalid params" do
      context "with a bad app key" do
        let(:auth_attributes) do
          base_auth.merge(application: '9999999')
        end

        let(:response) do
          VCR.use_cassette "pushwoosh/register_failure_bad_app_key" do
            subject.register(registration_attributes)
          end
        end

        it "responds with an error" do
          expect(response.code).to eq 401
        end

        it "has an error message" do
          expect(response.message).to eq "Application not found"
        end
      end

      context "with an invalid device token" do
        let(:device_token) { '999999999999999999999999999999' }

        let(:response) do
          VCR.use_cassette "pushwoosh/register_failure_invalid_token" do
            subject.register(registration_attributes)
          end
        end

        it "responds with an error" do
          expect(response.code).to eq 400
        end

        it "has an error message" do
          expect(response.message).to match /\AInvalid token/
        end
      end

      context "when missing the auth key" do
        let(:auth_attributes) do
          base_auth.delete(:auth)
        end

        it "raises an exception" do
          expect {
            subject.register(registration_attributes)
          }.to raise_error(ArgumentError)
        end
      end

      context "when missing the application key" do
        let(:auth_attributes) do
          base_auth.delete(:application)
        end

        it "raises an exception" do
          expect {
            subject.register(registration_attributes)
          }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "#unregister" do
    let(:auth_attributes) { base_auth }

    let(:unregister_attributes) do
      "hwid"
    end

    context "with valid params" do
      let(:response) do
        VCR.use_cassette "pushwoosh/unregister_success" do
          subject.unregister(unregister_attributes)
        end
      end

      it "responds with success" do
        expect(response.code).to eq 200
      end
    end

    context "with a missing hardware id" do
      let(:unregister_attributes) { nil }

      let(:response) do
        VCR.use_cassette "pushwoosh/unregister_failure" do
          subject.unregister(unregister_attributes)
        end
      end

      it "responds with an error" do
        expect(response.code).to eq 400
      end

      it "has an error message" do
        expect(response.message).to eq "No hwid given"
      end
    end
  end
end
