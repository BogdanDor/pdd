# Copyright (c) 2014-2022 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

module PDD
  module Rule
    module Roles
      # Rule for available roles checking.
      class Available
        # Ctor.
        # +xml+:: XML with puzzles
        def initialize(xml, roles)
          @xml = xml
          @roles = roles.split(',')
        end

        def errors
          @xml.xpath('//puzzle').map do |p|
            role = p.xpath('role/text()').to_s
            next nil if @roles.include?(role)

            "puzzle #{p.xpath('file/text()')}:#{p.xpath('lines/text()')}" +
              if role.empty?
                " doesn't define any role" \
                  ", while one of these roles is required: #{@roles}"
              else
                " defines role #{role}" \
                  ", while only these roles are allowed: #{@roles}"
              end
          end.compact
        end
      end
    end
  end
end
