module Fastlane
  module Actions
    class LastsecondGitTagAction < Action
      def self.run(params)
        tag_pattern_param = params[:pattern] ? "=#{params[:pattern]}" : ''
        last_tag = params[:last_tag_name] ? params[:last_tag_name] : ''
        hashs = Actions.sh('git tag -l | sort -V --reverse').chomp.split(" ")
        hashs.delete(last_tag)
        return hashs[0]
      end

      def self.description
        "Get the last second git tag"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :pattern,
                                       description: "Pattern to filter tags when looking for last one. Limit tags to ones matching given shell glob. If pattern lacks ?, *, or [, * at the end is implied",
                                       default_value: nil,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :last_tag_name,
                                       description: "exclude last_tag_name",
                                       default_value: nil,
                                       optional: true)
        ]
      end

      def self.output
        []
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["yaochenfeng"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
