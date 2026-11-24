#!/usr/bin/env bash

# This file is part of REANA.
# Copyright (C) 2017, 2018, 2021, 2023, 2024, 2026 CERN.
#
# REANA is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

# Disable management plugin in production (before server starts)
if [ "${DEBUG:-0}" -lt 1 ]; then
    rabbitmq-plugins disable --offline rabbitmq_management
fi

# Permit transient non-exclusive queues, since the `jobs-status` queue is one
# and RabbitMQ refuses them by default. Keep the maximum message size of
# RabbitMQ 3.8, since workflow progress messages can be large.
cat >/etc/rabbitmq/rabbitmq.config <<EOF
[
	{rabbit, [{default_user, <<"$1">>},{default_pass, <<"$2">>},{tcp_listeners, [{"0.0.0.0", 5672}]},{permit_deprecated_features, #{transient_nonexcl_queues => true}},{max_message_size, 134217728}]}
].
EOF
mkdir -p "$RABBITMQ_MNESIA_BASE"
chown rabbitmq:rabbitmq "$RABBITMQ_MNESIA_BASE"
# Limit maximum number of open file descriptors to avoid high memory usage
ulimit -n 1048576
exec rabbitmq-server
