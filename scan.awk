#!/usr/bin/awk -f
# List wifi network around

# Copyright (C) 2016 Chris Seymour <https://github.com/iiSeymour> 

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


$1 == "BSS" {
        MAC = $2
	    wifi[MAC]["enc"] = "Open"
}
$1 == "SSID:" {
        wifi[MAC]["SSID"] = $2
}
$1 == "freq:" {
        wifi[MAC]["freq"] = $NF
}
$1 == "signal:" {
        wifi[MAC]["sig"] = $2 " " $3
}
$1 == "WPA:" {
        wifi[MAC]["enc"] = "WPA"
}
$1 == "WEP:" {
        wifi[MAC]["enc"] = "WEP"
}
END {
    printf "%s\t\t%s\t%s\t\t%s\n","SSID","Frequency","Signal","Encryption"

    for (w in wifi) {
	printf "%s\t\t%s\t\t%s\t%s\n",wifi[w]["SSID"],wifi[w]["freq"],wifi[w]["sig"],wifi[w]["enc"]
    }
}
