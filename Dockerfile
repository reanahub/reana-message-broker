# This file is part of REANA.
# Copyright (C) 2017 CERN.
#
# REANA is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# REANA is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with REANA; if not, see <http://www.gnu.org/licenses>.
#
# In applying this license, CERN does not waive the privileges and immunities
# granted to it by virtue of its status as an Intergovernmental Organization or
# submit itself to any jurisdiction.

FROM rabbitmq:3.6-alpine
ADD start.sh /start.sh
RUN chmod 755 ./start.sh
#RUN rabbitmqctl add_user test 1234
#RUN rabbitmqctl add_vhost vhost
#RUN rabbitmqctl set_user_tags test test-tag
#RUN rabbitmqctl set_permissions -p myvhost myuser ".*" ".*" ".*"
EXPOSE 5672
EXPOSE 15672
CMD ["/start.sh", "test", "1234"]