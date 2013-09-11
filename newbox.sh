#!/bin/sh
vagrant box remove prod virtualbox
vagrant box remove factory virtualbox

vagrant box add prod ~/boxes/precise32.box
vagrant box add factory ~/boxes/factory.box

vagrant up 