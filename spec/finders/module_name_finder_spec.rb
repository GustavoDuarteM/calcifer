# frozen_string_literal: true

RSpec.describe Calcifer::Finders::ModuleNameFinder do
  describe '.execute' do
    subject { described_class.new(file).execute }

    context 'when the file only defines module' do
      let(:file) { File.open('spec/fixtures/module_definition.rb') }
      it 'return module name' do
        expect(subject).to eq('SomeModule')
      end
    end

    context 'when the file only defines class' do
      let(:file) { File.open('spec/fixtures/class_definition.rb') }
      it 'return module name' do
        expect(subject).to eq('SomeClass')
      end
    end

    context 'when the file does not define module or class' do
      let(:file) { File.open('spec/fixtures/module_and_class_definition.rb') }

      it 'return module and classs name' do
        expect(subject).to eq('SomeModule::SomeClass')
      end

      it 'will not include one-line class definition' do
        expect(subject).to_not include('SomeError')
      end
    end

    context 'when is empty file ' do
      let(:file) { File.open('spec/fixtures/empty_file.rb') }
      it 'return module name' do
        expect(subject).to be_nil
      end
    end

    context 'when is file is nil ' do
      let(:file) { nil }
      it 'return module name' do
        expect(subject).to be_nil
      end
    end
  end
end
