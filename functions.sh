# function railsapp {
# 	template=$1
# 	appname=$2
# 	shift 2
# 	rails $appname -m http://github.com/midwire/rails-templates/raw/master/$template.rb $@
# }
function rapp {
	appname=$1
	shift 1
	rails new $appname -m $HOME/Source/ruby/templates/default-template.rb -J -T $@
}
function eydeploy {
  # determine current git branch
  branch=$(git branch | grep '^*' |sed s/\*\ //)
  # get project name
  curdir=`pwd`
  project=`basename $curdir`
  if [ "$branch" == "master" ]; then
    env="$project"_staging
  else
    env="$project"_"$branch"
  fi
  ey deploy -e "$env" -r "$branch"
}
function eyssh {
  # determine current git branch
  branch=$(git branch | grep '^*' |sed s/\*\ //)
  # get project name
  curdir=`pwd`
  project=`basename $curdir`
  if [ "$branch" == "master" ]; then
    env="$project"_staging
  else
    env="$project"_"$branch"
  fi
  ey ssh -e "$env"
}
function ervm {
  gem="$1*"
  current=`rvm current`
  array=`ls -d1 ~/.rvm/gems/$current/gems/$gem`
  filename=''
  for d in $array; do
    filename="$d"
  done
  echo "Editing $filename"
  vi "$filename"
}
function gemdir {
  # echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
	ruby="$1"
  if [[ -z "$ruby" ]] ; then
		# use current selector if none passed
		cur=`rvm current`
		ruby=$cur
  fi
  rvm "$ruby"
  cd $(rvm gemdir)
  pwd
}
