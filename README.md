<h1>Dragon Byte</h1>
	<h2>Starting Point</h2>
		<p>A 42x42 pixels cursor with a dragon drawing that is available for web projects and X11.</p>
		<img src="./images/preview.png"/>
	<h2>Installation And Usage</h2>
		<h3>Installing From Releases</h3>
			<p>Ports of this cursor are available in the <code>Releases</code> page. You can download the latest release of the desired port and start using them by reading their installation instructions as following:</p>
			<h4>For web project</h4>
				<ul>
					<li>Download the release of the cursor for web projects: <code>web.zip</code> and unzip it in a formidable directory in your machine.</li>
					<li>Move the <code>css/dragon_byte</code> directory unziped to a formidable directory in your web project.</li>
					<li>Import the stylesheet file <code>dragon_byte.css</code> of the directory you have just copied inside your <code>HTML</code> file. You can use a <code>link</code> tag for that. Here is a template that you can use:</li>
					<pre><code>
&lt;link
	rel="stylesheet"
	href=""
/&gt;
					</code></pre>
					<p>You still have to insert the relative path to include that stylesheet yourself, in the <code>href</code> attribute shown.</p>
					<li>Write the CSS rules you need to apply the cursor inside the stylesheet that you imported. It already has all the necessary variables defined and in scope for you to do it. Every variable is prefixed with <code>dragon-byte</code> to make them unique. Want a usage example? What about applying the <code>default</code> cursor for your <code>body</code> element:</li>
					<pre><code>
body
{ cursor: var(--dragon-byte-default); }
					</code></pre>
					<p>Applying the remaining variables of the cursor is up to you: you will have to manually apply them to your page elements.</p>
				</ul>
			<h4>For X11</h4>
				<ul>
					<li>Download the release of the cursor for X11: <code>x11.zip</code> and unzip it in a formidable directory in your machine.</li>
					<li>Move the <code>x11/dragon_byte</code> directory unziped to either:</li>
						<ul>
							<li><code>/usr/share/icons</code> for a system wide installation (requires sudo privileges):</li>
							<pre><code>
mkdir -p /usr/share/icons
mv x11/dragon_byte /usr/share/icons
							</code></pre>
							<li><code>${HOME}/.local/share/icons</code></pre> for a user installation:</li>
							<pre><code>
mkdir -p ${HOME}/.local/share/icons
mv x11/dragon_byte ${HOME}/.local/share/icons
							</code></pre>
						</ul>
					<li>Apply the cursor using your system's settings application or by using an Xresource rule.</p>
					<li>Restart X11 for your changes to be properly set.</li>
				</ul>
		<h3>Building From Source</h3>
			<p>You can build different ports of the cursor by using a Docker container inside of a UNIX-like system: like MacOS or Linux, which will allow you to create a development environment with all the required dependencies easily.</p>
			<p>Unfortunely, Windows uses NTFS file system, so accessing the files created by a Linux container, which uses ext4 file system, may cause some incompatibily. If that is your case, you can try to run it using WSL (Windows Subsytem for Linux) or even on a virtual machine.</p>
			<p>Let's get through the steps to do it:</p>
			<ul>
				<li>Install Docker and enable its daemon.</li>
					<p>You can find all the information needed to install it in its <a href="https://docs.docker.com/get-docker/">official website</a>.</p>
				<li>Download this repository.</li>
					<p>If you have <code>git</code> installed, you can download it by using the following command:</p>
						<pre><code>git clone --depth=1 https://github.com/skippyr/dragon_byte</code></pre>
					<p>This will clone this repository to the directory <code>dragon_byte</code> in your current directory. If you would like to download it to another directory, simply add its path as an argument in the end of the command when you use it.</p>
					<p>If you do not have <code>git</code> installed, you still can download it from its page on GitHub. Access that page, then click on the button labeled <code>Code</code> on the top of the page, the click on the button labeled <code>Download ZIP</code> that will be in the floating menu that appears. This will download a compressed file containing the repository, you just have to unzip it.</p>
				<li>Access the repository's directory using a command-line application.</li>
					<pre><code>cd flamerial.nvim</code></pre>
					<p>If you have choosed another directory in previous step, substitute it in the command when you use it.</p>
				<li>Create a Docker container image using the <code>Dockerfile</code>.</li>
					<pre><code>docker build -t dragon_byte .</code></pre>
					<p>This command will create a Docker container image named <code>dragon_byte</code>. Even though it is possible to change that name, I recommend that you keep it the same.</p>
					<p>The process of creating an image may take some time depending of your internet connection. This process can also throw some errors sometimes: saying that it could not retrive packages. That is normal! Just try to create it again.</p>
				<li>Create and run a Docker container interactively using the image created in the previous step.</li>
					<pre><code>
mkdir -p distributions
docker run -it --name dragon_byte --mount type=bind,source=$(pwd)/distributions,target=/root/development/dragon_byte/distributions dragon_byte
					</code></pre>
					<p>Worths to mention: to be able to access the images and ports created, you will need to mount a directory of your file system inside the container using a bind type.</p>
					<p>In the command above, that directory will be the <code>distributions</code> directory that you will have create. It will be connected to the directory <code>/root/development/dragon_byte/distributions</code> inside the container, where the ports will be placed.</p>
				<li>Run the scripts to create the desired ports.</li>
					<p>Now, inside the running container, you can use the <code>ruby</code> interpreter to create all the desired ports, simply by running one of the scripts under the <code>scripts</code> directory. They all use a descriptive name, so you will find out what each of them build.</p>
					<p>For example, to create the port for X11:</p>
					<pre><code>ruby scripts/x11_port.rb</code></pre>
					<p>You can also prefer to automatically ZIP the port created by using the <code>--zip</code> flag to any of the scripts. Using the same example as above, but now zipping the final result:</p>
					<pre><code>ruby scripts/x11_port.rb --zip</code></pre>
			</ul>
			<p>All the ports will be placed inside the <code>distributions</code> directory inside the repository's root directory. As you have mounted that directory in your file system, you can access it directly in your host's file system too.</p>
			<p>After creating the desired ports. Exit the container using the <code>exit</code> command. As you will not need them anymore, use the following commands to remove the container and container image created:</p>
			<pre><code>
docker rm dragon_byte
docker rmi dragon_byte
			</code></pre>
			<p>If you are not using the <code>root</code> user, you will probably want to change the ownership of the <code>distributions</code> directory too so you can modify the files with your own user. Here is the command to do it:</p>
			<pre><code>sudo chmod -R $(whoami) distributions</code></pre>
			<p>You will need sudo privileges, as that directory will be owned by the <code>root</code> user.</p>
	<h2>Issues And Contributions</h2>
		<p>Learn how to report issues, questions and ideas and how to contribute to this project by reading its <a href="https://skippyr.github.io/materials/pages/contributions_guidelines.html">contributions guidelines</a>.</p>
	<h2>License</h2>
		<p>This project is released under terms of the MIT License. You can refer to the license as the file LICENSE in the repository's root directory.</p>
		<p>Copyright (c) 2023, Sherman Rofeman. MIT License.</p>

