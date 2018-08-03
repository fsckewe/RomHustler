require 'webrick'
include WEBrick

s = HTTPServer.new( 
:Port => 80, 
:DocumentRoot     => "RomBINS" 
)

class ROMFILEZ < WEBrick::HTTPServlet::FileHandler
 def do_GET(req, res)
        p "Req #{req.unparsed_uri}"
	Dir.chdir("RomBINS") do
		rombinfiles = Dir.glob("*").sort_by(&:downcase)
	end

        if req.unparsed_uri == "/roms/Naomi1/"
                html = "<html><body>Naomi1<br>"
		Dir.chdir("RomBINS/Naomi1") do
			naomi1files = Dir.glob("*").sort_by(&:downcase)
			naomi1files.each{|rom|
				html += "<a href='" + req.unparsed_uri + rom + "'>" + rom + "</a></br>"
			}
		end
                html += "</body></html>"
                res.body = html
                res['Content-Type'] = "text/html"

        elsif req.unparsed_uri == "/roms/Naomi2/"
                html = "<html><body>Naomi2<br>"
		Dir.chdir("RomBINS/Naomi2") do
			naomi2files = Dir.glob("*").sort_by(&:downcase)
			naomi2files.each{|rom|
                                html += "<a href='" + req.unparsed_uri + rom + "'>" + rom + "</a></br>"
                        }
		end
                html += "</body></html>"
                res.body = html
                res['Content-Type'] = "text/html"

        elsif req.unparsed_uri == "/roms/AtomisWave/"
                html = "<html><body>AtomisWave<br>"
		Dir.chdir("RomBINS/AtomisWave") do
			atomiswavefiles = Dir.glob("*").sort_by(&:downcase)
			atomiswavefiles.each{|rom|
                                html += "<a href='" + req.unparsed_uri + rom + "'>" + rom + "</a></br>"
                        }
		end
                html += "</body></html>"
                res.body = html
                res['Content-Type'] = "text/html"

        elsif req.unparsed_uri == "/roms/Chihiro/"
                html = "<html><body>Chihiro<br>"
		Dir.chdir("RomBINS/Chihiro") do
			chihirofiles = Dir.glob("*").sort_by(&:downcase)
			chihirofiles.each{|rom|
                                html += "<a href='" + req.unparsed_uri + rom + "'>" + rom + "</a></br>"
                        }
		end
                html += "</body></html>"
                res.body = html
                res['Content-Type'] = "text/html"

        elsif req.unparsed_uri == "/roms/Firmware/"
                html = "<html><body>Firmware<br>"
		Dir.chdir("RomBINS/Firmware") do
			firmwarefiles = Dir.glob("*").sort_by(&:downcase)
			firmwarefiles.each{|rom|
                                html += "<a href='" + req.unparsed_uri + rom + "'>" + rom + "</a></br>"
                        }
		end
                html += "</body></html>"
                res.body = html
                res['Content-Type'] = "text/html"

        else       
                print "Calling Super"
                super
        end
 end
end

class ROMS < HTTPServlet::AbstractServlet
 def do_GET(req, res)
        if req.unparsed_uri == "/"
		# AtomisWave  Chihiro Firmware  Naomi1  Naomi2  Triforce
		html = "<html><body><a href='/roms/Naomi1'>Naomi1 Roms</a><br>"
		html += "<a href='/roms/Naomi2'>Naomi2 Roms</a></body></html><br>"
		html += "<a href='/roms/AtomisWave'>AtomisWave Roms</a></body></html><br>"
		html += "<a href='/roms/Chihiro'>Chihiro Roms</a></body></html><br>"
		html += "<a href='/roms/Firmware'>Firmware Roms</a></body></html><br>"
		html += "</body></html>"
        	res.body = html
        	res['Content-Type'] = "text/html"
	end
 end
end

trap("INT"){ s.shutdown }
s.mount("/roms", ROMFILEZ, "RomBINS")
s.mount("/", ROMS)
s.start


