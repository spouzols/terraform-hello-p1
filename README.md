# Terraform: Hello, World!

## Chose an editor

Most editors have Terraform support through plugins.
IntelliJ has a really nice one, so does Visual Studio Code.

## Install Terraform

Use your favorite package manager, most have a Terraform package.

On OSX with homebrew: `brew install terraform`

## Setup AWS

This is a simple setup to run Terraform on AWS.
It uses profiles from the go and avoids having AWS credentials near the project folder.

### Install the AWS CLI

Again most package managers have it. On OSX with homebrew: `brew install awscli`.
This is not strictly necessary for Terraform itself, but it can be handy to have it around and has a
wizard to setup AWS. 

### Create an AWS account
You can [sign up here](https://portal.aws.amazon.com/billing/signup) if you have no account.

### Create an IAM user for Terraform
Go to the IAM service page, select the Users sidebar link. Click the Add user button, fill in a name
for this user, we will use `hello` in this example. Tick both the Programmatic access and
the AWS Management Console access check boxes (so you can also use this user to access the Web Console,
you should limit as much as possible using the root account).

For the Console password radio selector below, select Custom password, and fill in a strong password
preferably generated with a password manager - and save it your password manager.

Unselect the Require password reset checkbox. Then hit the Next button.

On the Set permissions (Step 2) screen, click on the Attach existing policies directly tab, then select
the `AdministratorAccess` policy from the list. Hit the Next button, then the Next button again.

On the Review screen (Step 4), check the username, and the Permissions summary which should contain
`AdministratorAccess`, then confirm creation by clicking on the Create user button.

Stay on the success screen, as you have to save the Access Key ID, and Secret Access Key. Run the following:

```
aws configure --profile hello
AWS Access Key ID [None]: XXXXXXXXXXXXXXXX
AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxxxxxxxxxxx
Default region name [None]: eu-west-1
Default output format [None]: json
```

It will prompt for the Access Key ID, and Secret Access Key, a default region and default format for outputs,
and it will create for you the `~/.aws` folder with `credentials` and `config` files in it.

### Set the profile to be used by the AWS provider
Start a shell you will use for all your Terraform commands for this project, and run the following in it:

```
# export AWS_DEFAULT_PROFILE=hello
export AWS_PROFILE=sandbox
```

Make sure to check the current default profile if you switch between shells before running Terraform or the AWS CLI.
You can do so with `echo $AWS_DEFAULT_PROFILE`.

You can check it's picking up the default profile and credentials you set up before by issuing:

```
aws iam get-user
```
