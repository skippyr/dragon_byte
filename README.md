<h1>Dragon Byte</h1>
	<h2>Installation And Usage</h2>
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
				<p>The flag <code>--depth</code> with value <code>1</code> specifies to <code>git</code> that you only want to download the latest commit, instead of the whole commit as it does by default, which will reduce the download size.</p>
				<p>If you do not have <code>git</code> installed, you can still download this repository from its page on GitHub: access that page, then click on the button labeled <code>Code</code> on the top of the page, then click on the button labeled <code>Download ZIP</code> in the floating menu that appears. This will download a compressed ZIP file with the repository inside, you just have to unzip it a formidable directory.</p>
			<li>Access the repository's directory.</li>
				<pre><code>cd dragon_byte</code></pre>
				<p>If you have chosen another directory in the last step, you will need to use its path instead when using the command.</p>
			<li>Now, let's create a Docker image from the Dockerfile that will be in the repository's root directory by using this command:</li>
				<pre><code>docker build -t dragon_byte .</code></pre>
				<p>This command will create a Docker image named <code>dragon_byte</code> with all the required dependencies to build it already installed on top of Arch Linux: a bledding-edge linux distribution, so everything will be up-to-date too.</p>
				<p>I recommend that you keep the same name for your image, as it will be used in the following examples too.</p>
			<li>Ok, finally, the great finalle: let's create and run a Docker container interactively by using the image created in the previous step.</li>
				<p>I will create and mount some directories of the host's file system in the container so you will be able to access the source images created and also the build. All the directories created are ignored in the <code>.gitignore</code>:</p>
			<pre><code>
mkdir -p source_images distributions
docker run -it --mount type=bind,source=$(pwd)/source_images,target=/root/development/dragon_byte/source_images --mount type=bind,source=$(pwd)/distributions,target=/root/development/dragon_byte/distributions dragon_byte
			</code></pre>
				<p>This command will do exactly what was explained. Here is a little explanation in the file architecture used:</p>
				<ul>
					<li>the source images will be placed under the directory <code>source_images</code>.</li>
					<li>the builds created will be placed under the directory <code>distributions</code>.</li>
				</ul>
				<p>At this point, you must be already inside the container inside the repository's root directory.</p>
			<li>Use <code>node</code> within the <code>scripts/wizard.js</code> script with the flag <code>--help</code> to print its help instructions and learn how to use it.</li>
				<pre><code>node scripts/wizard.js --help</code></pre>
		</ul>