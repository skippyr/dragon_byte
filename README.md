<h1>Dragon Byte</h1>
	<h2>Starting Point</h2>
		<p>A 42x42 pixels cursor with a dragon drawing that is available for web projects and X11.</p>
	<h2>Installation And Usage</h2>
		<h3>Building From Source</h3>
			<p>You can build the cursor for different ports by using a Docker container, which will allow you to create a development environment with all the required dependencies easily.</p>
			<p>Let's get through the steps to do it:</p>
			<ul>
				<li>Install Docker and enable its daemon.</li>
					<p>Docker is a cross-platform application: you can use it on Windows, MacOS and Linux. You can find all the information needed to install it in its <a href="https://docs.docker.com/get-docker/">official website</a>.</p>
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
				<li>Create and run Docker container interactively using the image created in the previous step.</li>
					<pre><code>
mkdir distributions
docker -it --name dragon_byte --mount type=bind,source=$(pwd)/distributions,target=/root/development/dragon_byte/distributions dragon_byte
					</code></pre>
					<p>Worths to mention: to be able to access the images and ports created, you will need to mount a directory of your file system inside the container using a bind type.</p>
					<p>In the command above, that directory will be the <code>distributions</code> directory that you will have create. It will be connected to the directory <code>/root/development/dragon_byte/distributions</code> inside the container, where the ports will be placed.</p>
					<p>If you are using Windows, please substitute <code>$(pwd)</code> by the repository's directory path when you use the command. Otherwise, that will point to an invalid source directory.</p>
				<li>Run the scripts to create the desired ports.</li>
					<p>Now, inside the running container, you can use the <code>ruby</code> interpreter to create all the desired ports, simply by running one of the scripts under the <code>scripts</code> directory. They all use a descriptive name, so you will find out what each of them build.</p>
					<p>For example, to create the port for X11:</p>
					<pre><code>ruby scripts/x11_port.rb</code></pre>
			</ul>
			<p>All the ports will be placed inside the <code>distributions</code> directory inside the repository's root directory. As you have mounted that directory in your file system, you can access it directly in your host's file system too.</p>
			<p>After creating the desired ports. Exit the container using the <code>exit</code> command. As you will not need them anymore, use the following commands to remove the container and container images created:</p>
			<pre><code>
docker rm dragon_byte
docker rmi dragon_byte
			</code></pre>
	<h2>Issues And Contributions</h2>
		<p>Learn how to report issues, questions and ideas and how to contribute to this project by reading its <a href="https://skippyr.github.io/materials/pages/contributions_guideline.html">contributions guideline</a>.</p>
	<h2>License</h2>
		<p>Flamerial is released under the MIT License. You can refer to the license as the file <code><a href="https://github.com/skippyr/dragon_byte/blob/main/LICENSE">LICENSE</a></code> in the root directory of this repository.</p>
		<p>Copyright (c) 2023, Sherman Rofeman. MIT License.</p>

