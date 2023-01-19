# cloudfix-linter-github-action-test

## Flow of Github action
1. Provide the tf.show file before starting the action
2. Use the [action](https://github.com/trilogy-group/cloudfix-linter-github-action) to generate mock recommendations
3. The action itself provides lintings as comments on the PR


## Steps of the Job in workflow:
```
jobs:  
  assign:
    name: "Cloudfix-Linter-Test"
    runs-on: ubuntu-latest
    steps:
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v1
      with:
        # terraform_version: 0.13.0:
        cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}

    - name: Checkout
      uses: actions/checkout@v3

    - name: Terraform-Show Preparation
      run: echo Going to run prepTfstate ; sh ./prepTfstate.sh
      shell: bash

    - name: "Recom"
      if: github.event_name == 'pull_request'
      uses: trilogy-group/cloudfix-linter-github-action@main
      with:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        pr_number: ${{ github.event.pull_request.number }}
        repository: ${{ github.repository }}
        mock_recommendations: 'true'
        cloudfix_username: ${{ secrets.CLOUDFIX_USERNAME }}
        cloudfix_password: ${{ secrets.CLOUDFIX_PASSWORD }}
```
1. Setup Terraform: Uses [this](https://github.com/hashicorp/setup-terraform) github action to setup terraform along with credential token (provided through github secrets) which will be used in futher terraform commands
2. Checkout: Uses [this](https://github.com/actions/checkout) github action to checkout the current repo
3. Terraform-Show Preparation: Uses [prepTfstate.sh](prepTfstate.sh) file to generate `tf.show` to be used in the next step
4. Recom: Uses our [cloudfix-linter-github-action](https://github.com/trilogy-group/cloudfix-linter-github-action) which has the following requirements
    1. GITHUB_TOKEN: Always made available by github itself as `secrets.GITHUB_TOKEN` with [these permissions](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token)
    2. pr_number, repository: Again made available by the workflow itself. It is used for making the comments on Pull request
    3. mock_redommendation: `true` for mock, `false` for using cloudfix API
    4. cloudfix_username, cloudfix_password: Cloudfix credentions (required if not using `mock_recommendations`)
