require 'spec_helper_acceptance'

require 'pry'

COMMENT = 'This is a test comment that is really cool'
COMMENT_DIR = '/tmp/comments'
COMMENT_FILE = 'very_funny.txt'
COMMENT_FILEPATH = COMMENT_DIR + '/' + COMMENT_FILE

describe 'comments::personal define' do
  describe 'main test' do
    describe file(COMMENT_FILEPATH) do
      it 'creates a comment file' do
        pp = <<-EOS
          file { '/tmp/comments':
            ensure => directory,
          }
          comments::personal { 'gregohardy':
            comment => "#{COMMENT}",
            path => "#{COMMENT_DIR}",
            filename => "#{COMMENT_FILE}",
          }
        EOS
        @result = AcceptanceHelper.agent_execute(pp)
        expect(@result.exit_code).to eq 2
      end
      describe file(COMMENT_DIR) do
        it { should be_directory }
      end

      describe file(COMMENT_FILEPATH) do
        its(:content) { should match(/#{COMMENT}/) }
      end
    end
  end
end
