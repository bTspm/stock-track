require "rails_helper"

describe ApplicationHelper do
  describe "#badge_format" do
    let(:additional_classes) { double(:additional_classes) }
    let(:badge_color) { double(:badge_color) }
    let(:content) { double(:content) }
    let(:options) { { badge_color: badge_color, class: additional_classes } }

    subject { helper.badge_format(content: content, options: options) }

    context "with content" do
      context "with options" do
        it { is_expected.to have_css('div', class: "badge #{badge_color} #{additional_classes}") }
      end

      context "without options" do
        let(:options) { {} }

        it { is_expected.to have_css('div', class: "badge badge-info") }
      end
    end
  end

  describe "#elements_in_single" do
    let(:element) { "Element" }
    let(:element_1) { "Element 1" }
    let(:elements) { [element, element_1] }

    subject { helper.elements_in_single(elements) }

    it "expect to return the elements with br tag" do
      expect(subject).to eq "Element<br>Element 1"
    end
  end

  describe "#fontawesome_icon" do
    let(:additional_classes) { "abc" }
    let(:icon) { "icon_class" }
    let(:icon_right_flag) { false }
    let(:options) { { class: additional_classes, icon_right: icon_right_flag } }
    let(:text) { "Text" }

    subject { helper.fontawesome_icon(name_icon_with_style: icon, options: options, text: text) }

    context "without options and text" do
      let(:options) { {} }
      let(:text) { nil }

      it { is_expected.to have_css("i", class: icon) }
    end

    context "with options and text" do
      context "class" do
        it { is_expected.to have_selector("i.icon_class.abc") }
      end

      context "icon_right" do
        context "true" do
          let(:icon_right_flag) { true }
          it { is_expected.to eq "Text <i class=\"icon_class abc\"></i>" }
        end

        context "false" do
          it { is_expected.to eq "<i class=\"icon_class abc\"></i> Text" }
        end
      end
    end
  end

  describe "#show_or_hide" do
    let(:value) { double(:value) }

    subject { helper.show_or_hide(value) }

    context "without value" do
      let(:value) { nil }

      it { is_expected.to eq "d-none" }
    end

    context "with value" do
      it { is_expected.to eq "" }
    end
  end
end
