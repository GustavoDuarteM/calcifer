# frozen_string_literal: true

RSpec.describe Calcifer::Buiders::RootFileBuilder do
  describe '.execute' do
    subject { described_class.new(file).build }

    context 'when is a regular file' do
      let(:file) { File.open('spec/fixtures/module_and_class_definition.rb') }

      it 'return module name' do
        expect(subject).to be_an_instance_of(Calcifer::Graph::RootFile)
      end

      it 'fill module_name ' do
        expect(subject.module_name).to eq('SomeModule::SomeClass')
      end

      it 'fill module_name ' do
        expect(subject.file_path).to eq('spec/fixtures/module_and_class_definition.rb')
      end

      it 'fill graph ' do
        expect(subject.graph_root).to be_an_instance_of(RGL::DirectedAdjacencyGraph)
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
