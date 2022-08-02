if ($PSVersionTable.PSVersion.Major -le 5) {
	function Remove-Alias ([string] $AliasName) {
		while (Test-Path Alias:$AliasName) {
			Remove-Item Alias:$AliasName -Force 2> $null
		}
	}
}

Remove-Alias gcb -Force -ErrorAction SilentlyContinue
Remove-Alias gl -Force -ErrorAction SilentlyContinue
Remove-Alias gm -Force -ErrorAction SilentlyContinue
Remove-Alias gp -Force -ErrorAction SilentlyContinue

function Get-Git-CurrentBranch {
	git symbolic-ref --quiet HEAD *> $null

	if ($LASTEXITCODE -eq 0) {
		return git rev-parse --abbrev-ref HEAD
	} else {
		return
	}
}

function ga {
	git add $args
}
function gb {
	git branch $args
}
function gcb {
	git checkout -b $args
}
function gcmsg {
	git commit -m $args
}
function gco {
	git checkout $args
}
function gcp {
	git cherry-pick $args
}
function gd {
	git diff $args
}
function ggsup {
	$CurrentBranch = Get-Git-CurrentBranch

	git branch --set-upstream-to=origin/$CurrentBranch
}
function gl {
	git pull $args
}
function glo {
	git log --oneline --decorate --color $args
}
function gm {
	git merge $args
}
function gp {
	git push $args
}
function gpf {
	git push --force-with-lease $args
}
function gsh {
	git show $args
}
function gst {
	git status $args
}
function gsu {
	git submodule update $args
}
function ggl {
	$CurrentBranch = Get-Git-CurrentBranch

	git pull origin $CurrentBranch
}
function ggp {
	$CurrentBranch = Get-Git-CurrentBranch

	git push origin $CurrentBranch
}

function lg {
	lazygit
}

Invoke-Expression (&starship init powershell)
