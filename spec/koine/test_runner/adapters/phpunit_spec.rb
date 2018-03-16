require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::Phpunit do
  let(:klass) { described_class }
  subject { klass.new(options: []) }

  describe '#accept?' do
    [
      'tests/foo/bar/FooTest.php',
      'tests/foo/FooTest.php',
      'tests/FooTest.php'
    ].each do |file|
      it "accept #{file}" do
        config = Koine::TestRunner::Configuration.new([file])
        expect(subject.accept?(config)).to be true
      end
    end

    [
      'foo.test.php',
      'Some.php'
    ].each do |file|
      it "rejects #{file}" do
        config = Koine::TestRunner::Configuration.new([file])
        expect(subject.accept?(config)).to be false
      end
    end
  end

  describe '#script_for' do
    it 'defaults to global installed phpunit' do
      allow(File).to receive(:exist?).with('vendor/bin/phpunit').and_return(false)

      expect(subject.send(:script_for, double(:config))).to eq('phpunit')
    end

    context 'when ./vendor/bin/phpunit exists' do
      it 'uses that script' do
        allow(File).to receive(:exist?).with('vendor/bin/phpunit').and_return(true)

        expect(subject.send(:script_for, double(:config))).to eq('./vendor/bin/phpunit')
      end
    end

    context 'with --color' do
      subject { klass.new }

      it 'defaults to global installed phpunit' do
        allow(File).to receive(:exist?).with('vendor/bin/phpunit').and_return(false)

        expect(subject.send(:script_for, double(:config))).to eq('phpunit --color')
      end

      context 'when ./vendor/bin/phpunit exists' do
        it 'uses that script' do
          allow(File).to receive(:exist?).with('vendor/bin/phpunit').and_return(true)

          expect(subject.send(:script_for, double(:config))).to eq('./vendor/bin/phpunit --color')
        end
      end
    end
  end

  describe '#test_command' do
    before do
      allow(File).to receive(:exist?).with('vendor/bin/phpunit').and_return(false)
    end

    let(:file) { 'spec/fixtures/FixturePhpUnitTest.php' }

    it 'returns the correct test command for all files' do
      configuration = Koine::TestRunner::Configuration.new([file, '--all'])

      expect(subject.test_command(configuration)).to eq('phpunit')
    end

    it 'returns the correct test command for intire single file' do
      configuration = Koine::TestRunner::Configuration.new([file])

      expect(subject.test_command(configuration)).to eq("phpunit #{file}")
    end

    it 'returns correct line when method method starts with function' do
      expect(subject.test_command(config_for_line(9)))
        .to eq("phpunit #{file} --filter '/\\btestShouldAddTwoNumbers\\b/'")

      expect(subject.test_command(config_for_line(10)))
        .to eq("phpunit #{file} --filter '/\\btestShouldAddTwoNumbers\\b/'")

      expect(subject.test_command(config_for_line(11)))
        .to eq("phpunit #{file} --filter '/\\btestShouldAddTwoNumbers\\b/'")

      expect(subject.test_command(config_for_line(12)))
        .to eq("phpunit #{file} --filter '/\\btestShouldAddTwoNumbers\\b/'")

      expect(subject.test_command(config_for_line(38)))
        .to eq("phpunit #{file} --filter '/\\baTestMarkedWithTestAnnotation\\b/'")

      expect(subject.test_command(config_for_line(39)))
        .to eq("phpunit #{file} --filter '/\\baTestMarkedWithTestAnnotation\\b/'")

      expect(subject.test_command(config_for_line(40)))
        .to eq("phpunit #{file} --filter '/\\baTestMarkedWithTestAnnotation\\b/'")

      expect(subject.test_command(config_for_line(40)))
        .to eq("phpunit #{file} --filter '/\\baTestMarkedWithTestAnnotation\\b/'")
    end
  end

  def config_for_line(line)
    Koine::TestRunner::Configuration.new([file, "--line=#{line}"])
  end
end
