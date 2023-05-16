<h1>Dragon Byte</h1>
	<h1>Starting Point</h1>
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
			<p>This repository contains the source files of the cursor for Gimp and a script written using Javascript to manage the build of the cursor for different ports: web and X11. To build it, you will need specific versions of certain softwares.</p>
			<p>As you would expect, the best way to run a build from these conditions is by using a Docker container. So let's get into the instructions:</p>
		<ul>
			<li>Install Docker and enable its daemon services.</li>
				<p>This time, I will not leave instructions about how to install Docker as it is not in the scope of this document. But there are many resources out there where you can learn about it, so you probably will not found it difficult.</p>
			<li>Download this repository to your machine.</li>
				<p>If you have <code>git</code> installed, you can do it using the following command:</p>
				<pre><code>git clone --depth=1 https://github.com/skippyr/dragon_byte</code></pre>
				<p>This command will download this repository to the directory <code>dragon_byte</code> in your current directory, but feel free to change it to a more formidable directory by adding its path in the end of the command when you use it.</p>
				<p>The flag <code>--depth</code> with value <code>1</code> specifies to <code>git</code> that you only want to download the latest commit, instead of the whole commit tree as it does by default, which will reduce the download size.</p>
				<p>If you do not have <code>git</code> installed, you can still download this repository from its page on GitHub: access that page, then click on the button labeled <code>Code</code> on the top of the page, then click on the button labeled <code>Download ZIP</code> in the floating menu that appears. This will download a compressed ZIP file with the repository inside, you just have to unzip it a formidable directory.</p>
			<li>Access the repository's directory.</li>
				<pre><code>cd dragon_byte</code></pre>
				<p>If you have chosen another directory in the last step, you will need to use its path instead when using the command.</p>
			<li>Now, let's create a Docker image from the <code>Dockerfile</code> that will be in the repository's root directory by using this command:</li>
				<pre><code>docker build -t dragon_byte .</code></pre>
				<p>This command will create a Docker image named <code>dragon_byte</code> with all the required dependencies to build it already installed on top of Arch Linux: a bledding-edge linux distribution, so everything will be up-to-date too.</p>
				<p>I recommend that you keep the same name for your image as well.</p>
			<li>Create and run a Docker container interactively by using the image created in the previous step.</li>
				<p>To be able to access the builds created, you will need to mount a directory called <code>distributions</code> from your host's file system inside the container. Here are the commands to use:</p>
				<pre><code>
mkdir -p distributions
docker run -it --name dragon_byte --mount type=bind,source=$(pwd)/distributions,target=/root/development/dragon_byte/distributions dragon_byte
				</code></pre>
				<p>This command will create and run a container called <code>dragon_byte</code>, and I recommend that you keep the same name as well.</p>
			<li>Execute the <code>scripts/wizard.js</code> script using <code>node</code> to build all the ports automatically.</li>
				<pre><code>node scripts/wizard.js</code></pre>
				<p>The ports will be placed under the directory <code>distributions</code> in the repository's root directory already in a ZIP format, you just have to use them.</p>
			<p>After creating those ports, you can exit the container using the <code>exit</code> command and safely delete it using these commands.</p>
			<pre><code>
docker rm dragon_byte
docker rmi dragon_byte
			</code></pre>
		</ul>