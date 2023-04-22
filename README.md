<h1>Dragon Byte</h1>
	<h2>Starting Point</h2>
		<p>My 32x32 cursor for X11 with a custom character that I drew.</p>
		<table>
			<thead>
				<tr>
					<td>Name</td>
					<td>Preview</td>
				</tr>
			</thead>
			<body>
				<tr>
					<td>left_ptr</td>
					<td><img src="./source_images/left_ptr.png"/></td>
				</tr>
				<tr>
					<td>xterm</td>
					<td><img src="./source_images/xterm.png"/></td>
				</tr>
			</body>
		</table>
	<h2>Installation And Usage</h2>
		<ul>
			<li>Install these dependencies:</li>
				<ul>
					<li><code>lua</code>:</li>
					<p>This is the programming language used in the <code>wizard.lua</code>, a script to manage the build of the cursor.</p>
					<li><code>xcursorgen</code>:</li>
					<p>This is the X11 util to create the cursor files from PNG images.</p>
				</ul>
			<li>Download this repository to a directory in your machine. If you have <code>git</code> installed, you can use it in the following command:</li>
			<pre><code>git clone --depth 1 https://github.com/skippyr/dragon_byte</code></pre>
			<p>This command will clone this repository to the directory <code>dragon_byte</code> in your current directory, but feel free to change to whatever directory you want to by adding it to the end of the command. The flag <code>--depth</code> with value <code>1</code> specifies to <code>git</code> that you only want to download the latest commit instead of the whole commit tree.</p>
			<p>If you do not have <code>git</code> installed, you can download this repository from its page on GitHub. Access that page, click on the <code>Code</code> button on the top of the page, then click on <code>Download ZIP</code>. This will download a ZIP file containing the repository, you just have to unzip it and move to the path you want it to be.</p>
			<li>Use the <code>wizard.lua</code> to build the cursor theme.</li>
			<pre><code>./wizard.lua build</code></pre>
			<li>Copy the cursor theme created to <code>~/.local/share/icons</code>. You may have to create that directory first.</li>
			<pre><code>mkdir -p ~/.local/share/icons</code></pre>
			<pre><code>cp -r ./dragon_byte ~/.local/share/icons</code></pre>
			<li>Apply the cursor theme using an icons management tool, such as <code>lxappearance</code> or by using Xresources rules. You may have to restart X11 for your changes to be properly set.</li>
		</ul>
	<h2>Issues And Contributions</h2>
		<p>Learn how to report issues, questions and ideas and how to contribute to this project by reading its <a href="https://skippyr.github.io/materials/pages/contributions_guideline.html">contributions guideline</a>.</p>
	<h2>License</h2>
		<p>River Dreams is released under the MIT License. You can refer to the license as the file <code><a href="https://github.com/skippyr/river_dreams/blob/main/LICENSE">LICENSE</a></code> in the root directory of this repository.</p>
		<p>Copyright (c) 2023, Sherman Rofeman. MIT License.</p>

