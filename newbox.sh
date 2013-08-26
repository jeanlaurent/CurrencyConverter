#!/bin/sh
vagrant box remove precise64 virtualbox
vagrant box add precise64 ~/boxes/precise64.box
vagrant up precise64