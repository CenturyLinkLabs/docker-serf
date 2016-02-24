#!/bin/bash
exec serf agent -rpc-addr=:7373 -tag role=serf-agent
