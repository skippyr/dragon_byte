<h1>Dragon Byte</h1>
	<h2>Starting Point</h2>
		<p>My 42x42 cursor with a dragon. It includes a wizard script to manage a port for X11.</p>
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
					<td>hand2</td>
					<td><img src="./source_images/hand2.png"/></td>
				</tr>
				<tr>
					<td>link</td>
					<td><img src="./source_images/link.png"/></td>
				</tr>
				<tr>
					<td>help</td>
					<td><img src="./source_images/help.png"/></td>
				</tr>
				<tr>
					<td>not-allowed</td>
					<td><img src="./source_images/not-allowed.png"/></td>
				</tr>
				<tr>
					<td>xterm</td>
					<td><img src="./source_images/xterm.png"/></td>
				</tr>
				<tr>
					<td>vertical-text</td>
					<td><img src="./source_images/vertical-text.png"/></td>
				</tr>
			</body>
		</table>
	<h2>Installation And Usage</h2>
		<ul>
			<li>Install these dependencies:</li>
				<ul>
					<li><code>lua</code>:</li>
					<p>This is the programming language used in the <code>wizard.lua</code>, a script to manage the build, install and uninstall of the cursor theme.</p>
					<li><code>xcursorgen</code>:</li>
					<p>This is the X11 util to create the cursor files from PNG images.</p>
				</ul>
			<li>Download this repository to a directory in your machine. If you have <code>git</code> installed, you can use it in the following command:</li>
			<pre><code>git clone --depth 1 https://github.com/skippyr/dragon_byte</code></pre>
			<p>This command will clone this repository to the directory <code>dragon_byte</code> in your current directory, but feel free to change to whatever directory you want to by adding it to the end of the command. The flag <code>--depth</code> with value <code>1</code> specifies to <code>git</code> that you only want to download the latest commit instead of the whole commit tree.</p>
			<p>If you do not have <code>git</code> installed, you can download this repository from its page on GitHub. Access that page, click on the <code>Code</code> button on the top of the page, then click on <code>Download ZIP</code>. This will download a ZIP file containing the repository, you just have to unzip it and move to the path you want it to be.</p>
			<li>Access the repository's directory.</li>
			<pre><code>cd dragon_byte</code></pre>
			<li>Use the wizard script <code>wizard.lua</code> without any arguments to see its usage instructions.</li>
			<pre><code>./wizard.lua</code></pre>
			<p>When running this wizard script, you must ensure that you run it in the root directory of the repository, as the <code>xcursorgen</code> util can only find the cursor images using its relative path.</p>
			<li>To install the cursor theme for your user, use it with the subcommand <code>install</code>:</li>
			<pre><code>./wizard.lua install</code></pre>
			<p>If you run the script as the <code>root</code> user, installation is performed in a system wide scope, at <code>/usr/share/icons</code>.</p>
			<p>If you run the script as a normal user, installation is performed for your current user only, at <code>${HOME}/.local/share/icons</code>.
			<li>After installing the cursor theme, you will need to apply it. You can do it using an icons management tool like <code>Cursors</code> for KDE, <code>Gnome Tweaks</code> for Gnome, <code>lxappearance</code> for others, or even using the X11 resources file <code>~/.Xresources</code>.</li>
			<li>At any point you can uninstall the cursor theme for your user using the same script, this time with the subcommand <code>uninstall</code>.
			<pre><code>./wizard.lua uninstall</code></pre>
			<p>This command will remove the cursor theme from the same directory used in the installation for your user.</p>
			<li>If you want to build and analyze the cursor files, you can use that same script with the subcommand <code>build</code>.</p>
			<pre><code>./wizard.lua build</code></pre>
			<p>The cursor files will be available in a directory called <code>dragon_byte</code> in your current directory.</p>
			<p>Further more, you can be creative. As this cursor uses a permissive license and is available: through PNG, in the directory <code>source_images</code>, Gimp files, in the directory <code>sources</code>, and contains its settings, in the directory <code>settings</code>, you can customize it as you want and embed it in other places than X11 like in a web page, for example. To get more information about the license used in this project, please refer to the License section.</p>
			<p>For the example of web page usage, you can refer to these materials if you want:</p>
				<ul>
					<li><a href="https://developer.mozilla.org/en-US/docs/Web/CSS/cursor">(MDN Web Docs) About The CSS cursor property</a>.</li>
					<li><a href="https://www.youtube.com/watch?v=FOC5RZHK_Gw">(YouTube - Leanne R) Applying A Custom PNG/SVG Cursor Using CSS</a>.</li>
				</ul>
		</ul>
	<h2>Issues And Contributions</h2>
		<p>Learn how to report issues, questions and ideas and how to contribute to this project by reading its <a href="https://skippyr.github.io/materials/pages/contributions_guideline.html">contributions guideline</a>.</p>
	<h2>License</h2>
		<p>Dragon Byte is released under the MIT License. You can refer to the license as the file <code><a href="https://github.com/skippyr/dragon_byte/blob/main/LICENSE">LICENSE</a></code> in the root directory of this repository.</p>
		<p>Copyright (c) 2023, Sherman Rofeman. MIT License.</p>

